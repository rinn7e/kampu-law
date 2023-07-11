import { useState } from 'preact/hooks';
import preactLogo from '../assets/preact.svg';
import viteLogo from '/vite.svg';
import { legislation_1 } from '../data/law';
import { pipe } from 'fp-ts/lib/function';
import * as A from 'fp-ts/lib/Array';

export function Home() {
	const [count, setCount] = useState(0);

	return (
		<div>
			{pipe(
				legislation_1.chapters[0].articles,
				A.mapWithIndex((i, a) =>
					<div>
						<h3>{a.index} </h3>
						<p>{a.content}</p>
					</div>
				)
			)
			}
		</div>
	);
}
